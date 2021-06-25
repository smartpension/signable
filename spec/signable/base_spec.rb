# frozen_string_literal: true

require 'spec_helper'

describe Signable::Base do
  it_behaves_like 'Query'
  it_behaves_like 'Model'
end
