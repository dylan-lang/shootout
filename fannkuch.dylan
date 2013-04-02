module: fannkuch

define library fannkuch
  use common-dylan;
  use io;
end library;

define module fannkuch
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

define constant <int-vector> = limited(<vector>, of: <integer>);

define function fannkuch (n :: <integer>)
 => (result :: <integer>, checksum :: <integer>);
  let perm :: <int-vector> = make(<int-vector>,size: n,fill: 0);
  let perm1 = make(<int-vector>,size: n,fill: 0);
  let count = make(<int-vector>,size: n,fill: 0);
  let max-flip-count :: <integer> = 0;
  let m :: <integer> = n - 1;
  let r :: <integer> = n;
  let odd :: <boolean> = #t;
  let checksum :: <integer> = 0;

  for (i from 0 below n)
    perm1[i] := i;
  end for;

  block(return)
    while (#t)
      while (r ~= 1)
        count[r - 1] := r;
        r := r - 1;
      end while;

      odd := ~odd;
      if (~ (perm1[0] = 0))
        for (i from 0 below n)
          perm[i] := perm1[i];
        end for;
        let flip-count :: <integer> = 0;
        while (perm[0] ~= 0)
          let k :: <integer> = perm[0];
          let k2 :: <integer> = floor/(k + 1, 2);
          for(i from 0 below k2)
            let tmp = perm[i];
            perm[i] := perm[k - i];
            perm[k - i] := tmp;
          end for;
          flip-count := flip-count + 1;
        end while;

        if (flip-count > max-flip-count)
          max-flip-count := flip-count;
        end if;
        checksum := checksum + if (odd) -flip-count else flip-count end;
      end if;

      block(break)
        while(#t)
          if (r = n)
            return(max-flip-count, checksum);
          end if;
          let perm0 :: <integer> = perm1[0];
          let i :: <integer> = 0;
          while (i < r)
            let j = i + 1;
            perm1[i] := perm1[j];
            i := j;
          end while;
          perm1[r] := perm0;
          count[r] := count[r] - 1;
          if (count[r] > 0)
            break();
          end if;
          r := r + 1;
        end while;
      end block;

    end while;
  end block;
end function fannkuch;

begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "10"));
  let (max-flips, checksum) = fannkuch(arg);
  format-out("%=\nPfannkuchen(%=) = %d\n", checksum, arg, max-flips);
end;
