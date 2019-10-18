module: dylan-user

define library n-body
  use common-dylan;
  use io;
end library;

define module n-body
  use common-dylan, exclude: { format-to-string };
  use transcendentals;
  use format-out;
end module;
