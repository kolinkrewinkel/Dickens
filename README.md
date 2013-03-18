Dickens
=======

Grammatically polished strings on iOS.

Text editing on iOS doesn't natively support correction of text elements such as quotes, apostrophes, and dashes. Even the built-in classes, such as NSDataDetector, pretend they don't exist. Enter Dickens.

**Usage**  
Copy the files in manually, or dynamically link it using the static library:  
1. Ensure `-ObjC` and `-all_load` are set in your "Other Linker Flags".  
2. Add Dickens to your workspace or project.  
3. Add libDickens to the linked libraries in your target settings.  
4. Set your library and header search paths correctly (relative to build/project folder [see demo as reference]). Ideally, you'll want to do so in such a way that you can `import <Dickens/Files.x>`  
5. Import the files where you need them.  
6. Use the methods! Remember not to block the main thread!

**Demo**  
Just type, as you would in a standard OS X field, to view the correction at work. The demo just uses the text view delegate methods (I tried doing this internally in the text view — no luck) to asynchrnously clean the text.

**Category**  
The provided NSString category provides a backend way of cleaning up strings the user (or you) have created. Simply use `string.polishedString` to get a cleaned version. As the entire string is parsed through, this method (synchronous) can take time. As shown in the demo, it's probably best to move this to a its own queue.


