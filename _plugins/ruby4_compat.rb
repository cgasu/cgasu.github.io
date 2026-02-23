# Shim for methods removed in Ruby 3.2+ (taint tracking).
# Required by Liquid 4.0.x (pinned by github-pages gem) on Ruby >= 3.2.
if RUBY_VERSION >= "3.2"
  class Object
    def tainted? = false
    def taint = self
    def untaint = self
    def frozen? = super
  end

  class String
    def tainted? = false
    def taint = self
    def untaint = self
  end
end
