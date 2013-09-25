class OperationCategory < EnumerateIt::Base
  associate_values(
    :receive   => [1, 'receive'],
    :sent  => [2, 'sent']
  )
end