module:         hash
synopsis:       implementation of "Hash (Associative Arrays) Access" benchmark
author:         Peter Hinely
copyright:      public domain


define function main () => ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));

  let c = 0;
  let table = make(<string-table>);

  for (i from 1 to arg)
    table[integer-to-string(i, base: 16)] := i;
  end;

  for (i from arg to 1 by -1)
    if (element(table, integer-to-string(i), default: #f))
      c := c + 1;
    end;
  end;

  format-out("%d\n", c);
end function;


main();
