module:         reversefile
synopsis:       implementation of "Reverse A File" benchmark
author:         Andreas Bogk
copyright:      public domain

define library reversefile
  use common-dylan;
  use io;
end library;

define module reversefile
  use common-dylan, exclude: { format-to-string };
  use standard-io;
  use streams;
end module;

begin
  let lines = #();
  let line = #f;
  while (line := read-line(*standard-input*, on-end-of-stream: #f))
    lines := add!(lines, line); // utilize the fact that lists are automatically built reversed
  end while;
  do(curry(write-line, *standard-output*), lines);
end;