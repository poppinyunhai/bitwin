class OperationStatus < EnumerateIt::Base
  associate_values(
    :new   => [1, 'new'],
    :over_time  => [2, 'over time']
  )
end
