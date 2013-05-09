require 'ostruct'
module Shatter
  module Delegator
  	attr_writer :delegate

  	def method_missing(*a)
      if a.first.is_a?(Symbol) and @delegate.respond_to?(a.first)
        return @delegate.send(*a) 
      end
      super
    end
  end

	refine Hash do
	  def shatter(&blk)
	  	blk.extend Delegator
	  	blk.delegate = OpenStruct.new self
      recursive_meta_fing_hack blk
	  end

	  #HACK inspiration: http://www.ruby-forum.com/topic/131910 
    def recursive_meta_fing_hack(blk)
      #preserve shadowed scope outside block
    	b = blk.binding #.dup
	  	each do |k,v|
	  	  begin
    	    return(b.instance_eval &blk)
	      rescue NameError
	      end
	      b.eval "#{k}=#{v.inspect}"
	    end
      b.instance_eval &blk
    end
	end
end
