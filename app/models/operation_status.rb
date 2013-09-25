class OperationStatus < EnumerateIt::Base
  associate_values(
    :un_confirmed   => [1, 'un_confirmed'],
    :confirmed  => [2, 'confirmed']
  )
end
