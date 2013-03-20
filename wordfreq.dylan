module: wordfreq

define library wordfreq
  use common-dylan;
  use io;
end library;

define module wordfreq
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;

begin
  let words = make(<string-table>);
  while(~stream-at-end?(*standard-input*))
    do(method(x)
           unless(x = "")
	     x := as-lowercase(x);
             let count = element(words, x, default: 0);
             words[x] := count + 1;
           end unless;
       end method, split(read-line(*standard-input*), ' '));
  end while;
  let results = make(<stretchy-vector>);
  for(w keyed-by k in words)
    add!(results, pair(k, w));
  end for;
  do(method(x)
         format-out("%s %=\n", x.head, x.tail)
     end method, sort(results, test: method(x, y)
                                         if(x.tail == y.tail)
                                           x.head > y.head
                                         else
                                           x.tail > y.tail
                                         end if; 
                                     end method));
end;
