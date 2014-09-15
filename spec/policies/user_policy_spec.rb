require 'rails_helper'
require 'pundit/rspec'
require 'matrix'

describe UserPolicy do
  subject { described_class }
  let(:resource) { build_stubbed :user }

  permission_matrix = Matrix[
    [nil,       :owner,  :admin,  :registered,  :guest],
    [:show?,    true,    true,    true,         true  ],
    [:update?,  true,    true,    false,        false ],
  ]

  actions           = permission_matrix.column_vectors[0][1..-1]
  roles             = permission_matrix.row_vectors[0][1..-1]
  permission_values = permission_matrix.minor(1..-1, 1..-1)

  actions.each_with_index do |action, action_index|
    permissions action do
      roles.each_with_index do |role, role_index|
        permission = permission_values[action_index, role_index]
        it "is #{permission ? "granted" : "denied"} to #{role}" do
          user = build_stubbed :user, role, resource: resource

          expect(subject).send(permission ? :to : :not_to, permit(
            user, resource
          ))
        end
      end
    end
  end
end
