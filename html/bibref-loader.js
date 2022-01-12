bibref().then(function(Module) {
 bibref_wasm = Module.cwrap("bibref_wasm", "string", ["string"])
 myinit(); // Start your program in the function myinit()...
});
