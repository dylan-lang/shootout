module: dylan-user

define library moments
  use common-dylan;
  use io;
end library;

define module moments
  use common-dylan, exclude: { format-to-string };
  use transcendentals;
  use format-out;
  use standard-io;
  use streams;
end module;
