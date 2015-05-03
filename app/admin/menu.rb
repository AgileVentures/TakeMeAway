ActiveAdmin.register Menu do
  permit_params :title, :start_date, :end_date

  form do |f|
    f.inputs 'Menu Details' do
      f.input :title
      f.input :start_date, as: :date_time_picker, datepicker_options: { format: 'Y-m-d'}
      f.input :end_date, as: :date_time_picker, datepicker_options: { format: 'Y-m-d'}
    end
    f.actions
  end
end
