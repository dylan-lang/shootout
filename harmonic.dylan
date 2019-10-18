module: harmonic

begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  for (n from arg above 0 by -1,
       i from 1.0 by 1.0,
       sum = 0.0 then sum + 1.0 / i)
  finally format-out("%=\n", sum);
  end for;
end;
