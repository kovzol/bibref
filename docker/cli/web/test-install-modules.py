#!/usr/bin/env python3
"""Exercise archive validation without network downloads or installed SWORD."""
import hashlib
import importlib.util
import io
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import zipfile

spec = importlib.util.spec_from_file_location('installer', Path(__file__).with_name('install-modules.py'))
installer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(installer)


class InstallerTest(unittest.TestCase):
    def archive(self, extra=None, config_version='1.0', data=True):
        stream = io.BytesIO()
        with zipfile.ZipFile(stream, 'w') as bundle:
            bundle.writestr('mods.d/hunruf.conf',
                            f'[HunRUF]\nVersion={config_version}\nDataPath=./modules/texts/ztext/hunruf/\n')
            if data:
                bundle.writestr('modules/texts/ztext/hunruf/ot.bzz', b'verse data')
            if extra:
                bundle.writestr(extra, b'unsafe')
        return stream.getvalue()

    def run_installer(self, archive, checksum=None):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            original = root / 'mods.d/lxx.conf'
            original.parent.mkdir()
            original.write_bytes(b'original Greek config')
            module = ('HunRUF', 'hunruf', '1.0', checksum or hashlib.sha256(archive).hexdigest())
            with patch.object(installer, 'ROOT', root), \
                 patch.object(installer, 'MODULES', (module,)), \
                 patch.object(installer.urllib.request, 'urlopen', return_value=io.BytesIO(archive)):
                installer.install()
            self.assertEqual(original.read_bytes(), b'original Greek config')
            self.assertEqual((root / 'modules/texts/ztext/hunruf/ot.bzz').read_bytes(), b'verse data')

    def test_preserves_existing_modules(self):
        self.run_installer(self.archive())

    def test_checksum_mismatch(self):
        with self.assertRaisesRegex(RuntimeError, 'checksum'):
            self.run_installer(self.archive(), '0' * 64)

    def test_unexpected_and_traversal_paths(self):
        for path in ('mods.d/lxx.conf', '../escape', '/escape', 'modules/texts/ztext/hunruf/../escape'):
            with self.subTest(path=path), self.assertRaisesRegex(RuntimeError, 'unexpected archive path'):
                self.run_installer(self.archive(extra=path))

    def test_version_mismatch(self):
        with self.assertRaisesRegex(RuntimeError, 'Version=1.0'):
            self.run_installer(self.archive(config_version='2.0'))

    def test_missing_data(self):
        with self.assertRaisesRegex(RuntimeError, 'missing module data'):
            self.run_installer(self.archive(data=False))


if __name__ == '__main__':
    unittest.main()
