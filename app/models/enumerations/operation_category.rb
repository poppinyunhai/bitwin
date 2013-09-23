class OperationCategory < EnumerateIt::Base
  associate_values(
    :receive   => [1, 'receive'],
    :generated  => [2, 'generated']
  )
end
