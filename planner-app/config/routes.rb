Rails.application.routes.draw do
  resources :task_groups do
    resources :tasks, except: %i[index show]
  end

  root "task_groups#index"
end
