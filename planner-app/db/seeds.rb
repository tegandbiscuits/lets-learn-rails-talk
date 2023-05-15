2.times do |task_group_number|
  task_group = TaskGroup.create!(
    title: "Task Group #{task_group_number}"
  )

  6.times do |task_number|
    due_date = if task_number.even?
                 task_number.months.from_now
               else
                 nil
               end
    completed = (task_number % 3).zero?

    task_group.tasks.create!(
      title: "Task #{task_group_number}x#{task_number}",
      due_at: due_date,
      completed: completed
    )
  end
end
