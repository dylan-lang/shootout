module: mandelbrot

define library mandelbrot
  use common-dylan;
  use io;
end library;

define module mandelbrot
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;

// double float slot assignment implementation makes use of heap allocation,
// using a double float vector of size 1 avoids that allocation.
define constant <double-vector-1> = limited(<vector>, of: <double-float>, size: 1);

begin
  let w = string-to-integer(element(application-arguments(), 0, default: "200"));
  let h = w;
  let bit-num = 0;
  let byte-acc = 0;
  let limit2 = 4.0d0;
  let Zr = make(<double-vector-1>, fill: 0.0d0);
  let Zi = make(<double-vector-1>, fill: 0.0d0);
  let Cr = make(<double-vector-1>, fill: 0.0d0);
  let Ci = make(<double-vector-1>, fill: 0.0d0);
  let Tr = make(<double-vector-1>, fill: 0.0d0);
  let Ti = make(<double-vector-1>, fill: 0.0d0);
  let tmp = make(<double-vector-1>, fill: 0.0d0);
  
  format-out("P4\n%d %d\n",w,h);

  for (y :: <double-float> from 0.0d0 below h)
    for (x :: <double-float> from 0.0d0 below w)
      Zr[0] := (Zi[0] := 0.0d0);
      Cr[0] := (2 * x / as(<double-float>, w) - 1.5);
      Ci[0] := (2 * y / as(<double-float>, h) - 1);
      byte-acc := ash(byte-acc,1);
      bit-num := bit-num + 1;
      block (done)
        for (i from 0 below 50)
          Tr[0] := Zr[0] * Zr[0] - Zi[0] * Zi[0] + Cr[0];
          Ti[0] := 2 * Zr[0] * Zi[0] + Ci[0];
          Zr[0] := Tr[0];
          Zi[0] := Ti[0];
          tmp[0] := Zr[0] * Zr[0] + Zi[0] * Zi[0];
          if (tmp[0] > limit2)
            done();
          end if;
        end for;
      end block;
      if (tmp[0] < limit2)
        byte-acc := byte-acc + 1;
      end if;
      if (bit-num = 8)
        write-element(*standard-output*,as(<byte-character>,byte-acc));
        bit-num := (byte-acc := 0);
      elseif (x = w - 1)
        byte-acc := ash(byte-acc, (8 - modulo(w,8)));
        write-element(*standard-output*,as(<byte-character>,byte-acc));
        bit-num := (byte-acc := 0);
      end if;
    end for;
  end for;
end;
