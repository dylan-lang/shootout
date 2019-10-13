module: sumcol

begin
  let sum :: <integer> = 0;
  block ()
    while(#t)
      sum := sum + string-to-integer(read-line(*standard-input*));
    end while;
  exception (e :: <end-of-stream-error>)
  end;
  format-out("%=\n", sum);
end;
