require 'date'
class Grid
    #validate :day
    #validates :professional, presence: false 
    attr_accessor :day, :professional
    def initialize(day=nil, professional=nil)
        self.day=day
        self.professional=professional 
    end       

    def valid_day?
        begin
            DateTime.strptime(self.date , "%Y-%m-%d")
            return true
        rescue => exception
            return false #No es valida la fecha
        end   
    end 
    
    def valid_professional?
        if Professional.where(name:self.professional).first
            true
        else
            false
        end
    end
end