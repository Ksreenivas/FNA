# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


FindingType.create(category_name: 'Non-Conformity')
FindingType.create(category_name: 'Non-Compliance')
FindingType.create(category_name: 'Major Non Conformity')
FindingType.create(category_name: 'Minor Non Conformity')
FindingType.create(category_name: 'Scope for improvement')

Risk.create(risk_name: 'Critical')
Risk.create(risk_name: 'High')
Risk.create(risk_name: 'Medium')
Risk.create(risk_name: 'Low')
Risk.create(risk_name: 'No Risk')

FindingStatus.create(status_name: 'CAPA Pending')
FindingStatus.create(status_name: 'CAPA Submitted')
FindingStatus.create(status_name: 'Closed')

status = FindingStatus.find_by_status_name('CAPA Submitted')
status.update_attributes!(:status_name => 'Under Review')