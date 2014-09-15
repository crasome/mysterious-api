require 'rails_helper'
require 'matrix'
require_relative "shared_examples/permissin_matrix_specs"

describe FolderPolicy do
  subject { described_class }
  let(:resource) { build_stubbed :folder }

  include_examples :permission_matrix, matrix: Matrix[
    [nil,       :owner,  :admin,  :registered,  :guest],
    [:show?,    true,    true,    true,         true  ],
    [:update?,  true,    true,    false,        false ],
    [:create?,  true,    true,    true,         false ],
  ]
end
