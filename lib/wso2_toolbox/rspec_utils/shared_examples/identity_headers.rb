module Wso2Toolbox
  module RspecUtils
    module SharedExamples
      module IdentityHeaders
        RSpec.shared_context 'stub identity headers' do |controller_class|
          let(:user_hash) do
            {
              'id' => 1,
              'user_name' => 'app-user',
              'email' => 'noreplay@guideinvestimentos.com.br',
              'remote_ip' => '127.0.0.1'
            }
          end
          let(:base64_header) { Base64.strict_encode64(user_hash.to_s) }
          let(:headers_hash) { { 'HTTP_USER_IDENTIFIER' => base64_header } }
          let(:request_obj) do
            instance_double('ActionDispatch::Request', headers: headers)
          end

          before(:each) do
            allow_any_instance_of(controller_class).
              to receive(:request) { request_obj }
          end
        end

        RSpec.shared_examples 'set_paper_trail_whodunnit' do
          describe 'before_action' do
            it { is_expected.to use_before_action(:set_paper_trail_whodunnit) }
          end
        end

        RSpec.shared_examples 'get user identifier' do |controller_class|
          include_context 'stub identity headers', controller_class

          describe '#user_identifier' do
            context 'receive user identifier header' do
              let(:headers) do
                ActionDispatch::Http::Headers.from_hash(headers_hash)
              end
              it { expect(subject.user_identifier).to eq user_hash.to_s }
            end

            context 'not receive user identifier header' do
              let(:headers) { ActionDispatch::Http::Headers.from_hash({}) }
              it { expect(subject.user_identifier).to be_nil }
            end
          end
        end

        RSpec.shared_examples 'get user for paper_trail' do |controller_class|
          include_context 'stub identity headers', controller_class

          describe '#user_for_paper_trail' do
            context 'receive user identifier header' do
              before(:each) do
                allow_any_instance_of(controller_class).
                  to receive(:user_identifier) { user_hash.to_s }
              end

              it { expect(subject.user_for_paper_trail).to eq user_hash.to_s }
            end
            context 'receive user identifier header' do
              before(:each) do
                allow_any_instance_of(controller_class).
                  to receive(:user_identifier) { nil }
              end

              it { expect(subject.user_for_paper_trail).to be_nil }
            end
          end
        end

        RSpec.shared_examples 'audit user' do |controller_class|
          it_behaves_like 'set_paper_trail_whodunnit'
          it_behaves_like 'get user identifier', controller_class
          it_behaves_like 'get user for paper_trail', controller_class
        end
      end
    end
  end
end
