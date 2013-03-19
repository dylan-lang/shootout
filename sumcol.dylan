module: sumcol

define library sumcol
  use common-dylan;
  use io;
end library;

define module sumcol
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;

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
