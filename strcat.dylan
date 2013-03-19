module: strcat

define library strcat
  use common-dylan;
  use io;
end library;

define module strcat
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

begin
  let s = make(<stretchy-vector>);
  for(i from 0 below string-to-integer(application-arguments()[0]))
    do(curry(add!, s), "hello\n");
  end for;
  format-out("%=\n", s.size);
end;