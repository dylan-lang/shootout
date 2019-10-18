module: strcat

begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  let s = make(<stretchy-vector>);
  for(i from 0 below arg)
    do(curry(add!, s), "hello\n");
  end for;
  format-out("%=\n", s.size);
end;