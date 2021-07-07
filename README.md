# ARCinDelphi
Some musings about hiding methods and ARC idiosyncrasies
File this under Delphi Compiler Red Herrings. I didn't start out to try to  understand this, but that's the way it worked out. Obviously, I had bugs. Not so obviously, it took me a long time to understand why.

There's a blog post about this that you can read at [Delphi Red Herrings: Hidden Virtual Methods](https://delphichops.blogspot.com/2021/07/arc-in-delphi.html "Delphi Red Herrings").

## Thesis

The basic meat of this small demo and the accompanying blog is the ominous message from the Delphi compiler:

```
method... hides virtual method of base type ...
which turns out to be relatively ambiguous if not meaningless.
```

Some immediate questions come to mind when you get this message:
1.  Hidden from who? 
2.  What does this mean for my code?

I don't pretend to understand all the nuance, but the blog post explores these questions and this small demo program permits some quick experimentation so the interested user can see the impact of `ARC`, the `override` directive and any other syntactic trinket he or she would like to experiment with.
