#!/usr/bin/env python3
"""Install checksum-pinned lookup modules without changing the default bundle."""
import hashlib
from pathlib import Path
import tempfile
import urllib.request
import zipfile

MODULES = (
    ('HunRUF', 'hunruf', '1.0', 'b6db6d7e03b385e65fc9ca97e1c35ea754a0db5745e809335ef91c6497a8fa8f'),
    ('Aleppo', 'aleppo', '2.0.1', '6a4fa5968075669695a05050a4882cb2fdb93790f041b9e2e3bace1a692c0798'),
)
ROOT = Path.home() / '.sword'


def install():
    original = {p: hashlib.sha256(p.read_bytes()).digest()
                for p in ROOT.rglob('*') if p.is_file()}
    for name, folder, version, checksum in MODULES:
        url = f'https://crosswire.org/ftpmirror/pub/sword/packages/rawzip/{name}.zip'
        with tempfile.TemporaryFile() as archive:
            with urllib.request.urlopen(url, timeout=120) as response:
                while chunk := response.read(1024 * 1024):
                    archive.write(chunk)
            archive.seek(0)
            if hashlib.sha256(archive.read()).hexdigest() != checksum:
                raise RuntimeError(f'{name}: archive checksum changed; review before updating the pin')
            archive.seek(0)
            with zipfile.ZipFile(archive) as bundle:
                config = f'mods.d/{folder}.conf'
                data = f'modules/texts/ztext/{folder}/'
                entries = bundle.infolist()
                for entry in entries:
                    path = Path(entry.filename)
                    if (path.is_absolute() or '..' in path.parts or
                        not (entry.filename == config or entry.filename.startswith(data))):
                        raise RuntimeError(f'{name}: unexpected archive path {entry.filename}')
                settings = bundle.read(config).decode('utf-8')
                lines = settings.splitlines()
                for required in (f'[{name}]', f'Version={version}', f'DataPath=./{data}'):
                    if required not in lines:
                        raise RuntimeError(f'{name}: missing expected setting {required}')
                if not any(e.filename.startswith(data) and e.file_size for e in entries):
                    raise RuntimeError(f'{name}: missing module data')
                bundle.extractall(ROOT)
        print(f'Installed {name} {version} ({checksum})')
    for path, digest in original.items():
        if hashlib.sha256(path.read_bytes()).digest() != digest:
            raise RuntimeError(f'Existing module file changed: {path}')


if __name__ == '__main__':
    install()
