module: takfp

define constant <fp> = <single-float>;

begin
  local method tak(x :: <fp>, y :: <fp>, z :: <fp>) => (res :: <fp>)
          case
            x > y  => tak(tak(x - 1.0s0, y, z),
                          tak(y - 1.0s0, z, x),
                          tak(z - 1.0s0, x, y));
            otherwise => z;
          end;
        end method;

  let n = string-to-integer(element(application-arguments(), 0, default: "1"));
  // FIXME: "%.1f" is not supported as control-string, as a result 7 decimal
  // digits are printed instead of 1.
  //format-out("%.1f\n", tak(3.0s0 * n, 2.0s0 * n, 1.0s0 * n));
  format-out("%=\n", tak(3.0s0 * n, 2.0s0 * n, 1.0s0 * n));
end;

