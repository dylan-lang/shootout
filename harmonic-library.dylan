module: dylan-user

define library harmonic
  use common-dylan;
  use io;
end library;

define module harmonic
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
