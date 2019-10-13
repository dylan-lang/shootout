module: dylan-user

define library spectralnorm
  use common-dylan;
  use io;
end library;

define module spectralnorm
  use common-dylan, exclude: { format-to-string };
  use transcendentals;
  use format-out;
end module;
