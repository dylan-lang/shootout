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
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  let s = make(<stretchy-vector>);
  for(i from 0 below arg)
    do(curry(add!, s), "hello\n");
  end for;
  format-out("%=\n", s.size);
end;