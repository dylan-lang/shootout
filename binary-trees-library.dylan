module: dylan-user

define library binary-trees
  use common-dylan;
  use io;
end library;

define module binary-trees
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
