module:         spellcheck
synopsis:       implementation of "Spell Checker" benchmark
author:         Peter Hinely
copyright:      public domain



define function spellcheck () => ()
  let dictionary = make(<case-insensitive-string-table>);
  
  with-open-file (file = "Usr.Dict.Words")
    let line = #f;
    while (line := read-line(file, on-end-of-stream: #f))
      dictionary[line] := #t;
    end while;
  end with-open-file;
  
  let word-to-check = #f;

  while (word-to-check := read-line(*standard-input*, on-end-of-stream: #f))
    unless (element(dictionary, word-to-check, default: #f))
      format-out("%s\n", word-to-check);
    end;
  end while;
end function;


spellcheck();