module: dylan-user

define library fannkuch
  use common-dylan;
  use io;
end library;

define module fannkuch
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
