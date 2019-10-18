module: dylan-user

define library matrix
  use common-dylan;
  use io;
end library;

define module matrix
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
