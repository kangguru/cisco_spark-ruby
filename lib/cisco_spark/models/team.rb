require "cisco_spark/model"

module CiscoSpark
  class Team
    include Model
    resource 'teams'

    attributes(
      id: DataCaster::String,
      name: DataCaster::String,
      created: DataCaster::DateTime
    )
    mutable_attributes :name

    def memberships(options={})
      options[:team_id] = id
      CiscoSpark::TeamMembership.fetch_all(options)
    end

    def add_person(person, options={})
      CiscoSpark::TeamMembership.new(
        team_id: id,
        person_id: person.id,
        is_moderator: options.fetch(:is_moderator, false),
      ).persist
    end
  end
end
