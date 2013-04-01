module: n-body

define library n-body
  use common-dylan;
  use io;
end library;

define module n-body
  use common-dylan, exclude: { format-to-string };
  use transcendentals;
  use format-out;
end module;

// double float slot assignment implementation makes use of heap allocation,
// using a double float vector of size 1 avoids that allocation.
define constant <double-vector-1> = limited(<vector>, of: <double-float>, size: 1);

define sealed class <planet> (<object>)
  constant slot x :: <double-vector-1>, required-init-keyword: x:;
  constant slot y :: <double-vector-1>, required-init-keyword: y:;
  constant slot z :: <double-vector-1>, required-init-keyword: z:;
  constant slot vx :: <double-vector-1>, required-init-keyword: vx:;
  constant slot vy :: <double-vector-1>, required-init-keyword: vy:;
  constant slot vz :: <double-vector-1>, required-init-keyword: vz:;
  constant slot mass :: <double-float>, required-init-keyword: mass:;
end class <planet>;

define sealed inline method make(class == <planet>, #rest all-keys, #key)
 => (object)
  next-method();
end method make;

define constant <planet-vector> = <list>;
define constant $pi = $double-pi;
define constant $solar-mass = 4 * $pi * $pi;
define constant $days-per-year = 365.24;

define constant $bodies :: <planet-vector> = make(<planet-vector>, size: 5);
$bodies[0] := make (<planet>,
                    x: make(<double-vector-1>, fill: 0.0d0),
                    y: make(<double-vector-1>, fill: 0.0d0),
                    z: make(<double-vector-1>, fill: 0.0d0),
                    vx: make(<double-vector-1>, fill: 0.0d0),
                    vy: make(<double-vector-1>, fill: 0.0d0),
                    vz: make(<double-vector-1>, fill: 0.0d0),
                    mass: $solar-mass);
$bodies[1] := make (<planet>,
                    x: make(<double-vector-1>, fill: 4.84143144246472090e+00),
                    y: make(<double-vector-1>, fill: -1.16032004402742839e+00),
                    z: make(<double-vector-1>, fill: -1.03622044471123109e-01),
                    vx: make(<double-vector-1>, fill: 1.66007664274403694e-03 * $days-per-year),
                    vy: make(<double-vector-1>, fill: 7.69901118419740425e-03 * $days-per-year),
                    vz: make(<double-vector-1>, fill: -6.90460016972063023e-05 * $days-per-year),
                    mass: 9.54791938424326609e-04 * $solar-mass);
$bodies[2] := make (<planet>,
                    x: make(<double-vector-1>, fill: 8.34336671824457987e+00),
                    y: make(<double-vector-1>, fill: 4.12479856412430479e+00),
                    z: make(<double-vector-1>, fill: -4.03523417114321381e-01),
                    vx: make(<double-vector-1>, fill: -2.76742510726862411e-03 * $days-per-year),
                    vy: make(<double-vector-1>, fill: 4.99852801234917238e-03 * $days-per-year),
                    vz: make(<double-vector-1>, fill: 2.30417297573763929e-05 * $days-per-year),
                    mass: 2.85885980666130812e-04 * $solar-mass);
$bodies[3] := make (<planet>,
                    x: make(<double-vector-1>, fill: 1.28943695621391310e+01),
                    y: make(<double-vector-1>, fill: -1.51111514016986312e+01),
                    z: make(<double-vector-1>, fill: -2.23307578892655734e-01),
                    vx: make(<double-vector-1>, fill: 2.96460137564761618e-03 * $days-per-year),
                    vy: make(<double-vector-1>, fill: 2.37847173959480950e-03 * $days-per-year),
                    vz: make(<double-vector-1>, fill: -2.96589568540237556e-05 * $days-per-year),
                    mass: 4.36624404335156298e-05 * $solar-mass);
$bodies[4] := make (<planet>,
                    x: make(<double-vector-1>, fill: 1.53796971148509165e+01),
                    y: make(<double-vector-1>, fill: -2.59193146099879641e+01),
                    z: make(<double-vector-1>, fill: 1.79258772950371181e-01),
                    vx: make(<double-vector-1>, fill: 2.68067772490389322e-03 * $days-per-year),
                    vy: make(<double-vector-1>, fill: 1.62824170038242295e-03 * $days-per-year),
                    vz: make(<double-vector-1>, fill: -9.51592254519715870e-05 * $days-per-year),
                    mass: 5.15138902046611451e-05 * $solar-mass);

define function advance(planets :: <planet-vector>, dt :: <double-float>)
  local method advance-recursive
            (planets :: <planet-vector>, dt :: <double-float>)
          let b :: <planet> = head(planets);
          let rest :: <list> = tail(planets);
          for (b2 :: <planet> in rest)
            let dx = b.x[0] - b2.x[0];
            let dy = b.y[0] - b2.y[0];
            let dz = b.z[0] - b2.z[0];
            let distance = sqrt(dx * dx + dy * dy + dz * dz);
            let mag = dt / (distance * distance * distance);
            
            let tmp :: <double-float> = b2.mass * mag;
            b.vx[0] := b.vx[0] - dx * tmp;
            b.vy[0] := b.vy[0] - dy * tmp;
            b.vz[0] := b.vz[0] - dz * tmp;
            
            tmp := b.mass * mag;
            b2.vx[0] := b2.vx[0] + dx * tmp;
            b2.vy[0] := b2.vy[0] + dy * tmp;
            b2.vz[0] := b2.vz[0] + dz * tmp;
          end for;
          if (rest ~= #())
            advance-recursive(rest,dt);
          end if;
        end method advance-recursive;
  advance-recursive(planets,dt);
  for (b :: <planet> in planets)
    b.x[0] := b.x[0] + dt * b.vx[0];
    b.y[0] := b.y[0] + dt * b.vy[0];
    b.z[0] := b.z[0] + dt * b.vz[0];
  end for;
end function advance;

define function energy(planets :: <planet-vector>, e :: <double-vector-1>)
 => (result :: <double-vector-1>)
  let b :: <planet> = head(planets);
  let rest = tail(planets);
  e[0] := e[0] + 0.5 * b.mass * (b.vx[0] * b.vx[0] + b.vy[0] * b.vy[0] + b.vz[0] * b.vz[0]);
  for(b2 :: <planet> in rest)
    let dx = b.x[0] - b2.x[0];
    let dy = b.y[0] - b2.y[0];
    let dz = b.z[0] - b2.z[0];
    let distance = sqrt(dx * dx + dy * dy + dz * dz);
    e[0] := e[0] - (b.mass * b2.mass) / distance;
  end for;
  if(rest ~= #())
    e := energy(rest,e);
  end if;
  e;
end function energy;

define function offset-momentum(planets :: <planet-vector>)
  let px = make(<double-vector-1>, fill: 0.0d0);
  let py = make(<double-vector-1>, fill: 0.0d0);
  let pz = make(<double-vector-1>, fill: 0.0d0);
  for (b :: <planet> in planets)
    px[0] := px[0] + b.vx[0] * b.mass;
    py[0] := py[0] + b.vy[0] * b.mass;
    pz[0] := pz[0] + b.vz[0] * b.mass;
  end for;
  let b = planets[0];
  b.vx[0] := -px[0] / $solar-mass;
  b.vy[0] := -py[0] / $solar-mass;
  b.vz[0] := -pz[0] / $solar-mass;
end function offset-momentum;

begin
  let n = string-to-integer(element(application-arguments(), 0, default: "1000"));
  
  offset-momentum($bodies);
  // FIXME: "%.9f" is not supported as control-string, as a result 7 decimal
  // digits and 'd' marker is printed, instead of 9 decimal digits without
  // marker.
  //format-out("%.9f\n", energy($bodies,0.0));
  format-out("%=\n", energy($bodies, make(<double-vector-1>, fill: 0.0d0))[0]);
  for (i from 1 to n)
    advance($bodies,0.01d0);
  end for;
  // FIXME: "%.9f" is not supported as control-string, as a result 7 decimal
  // digits and 'd' marker is printed, instead of 9 decimal digits without
  // marker.
  //format-out("%.9f\n", energy($bodies,0.0));
  format-out("%=\n", energy($bodies, make(<double-vector-1>, fill: 0.0d0))[0]);
end;
