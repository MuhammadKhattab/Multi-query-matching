# Multi-query-matching
Quickly find a list of dictionary entries in a text, and tag the matches.

Ex:

Dict: ['quick brown', 'brown fox', 'dog']

Text: The quick brown fox jumps over the lazy dog

Output: The \<FOUND\>quick brown\</FOUND\> fox jumps over the lazy \<FOUND\>dog\</FOUND\>

The script currently needs no command line arguments, because it loads the dictionary and text from 'dict' and 'text' in the same directory as the script, but this is to be changed. It's a very rudimentary script that I haven't worked on for some time (but was sufficient for the purpose that it was created for at the time); it needs a lot of improvements and comments. Next I'll see if I can add regular expressions to the dictionary entries.
