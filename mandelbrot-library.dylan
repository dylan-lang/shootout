module: dylan-user

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
