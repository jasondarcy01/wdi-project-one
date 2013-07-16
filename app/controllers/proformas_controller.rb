class ProformasController < ApplicationController
  def new
      #dashboard
  end

  def create
    input = Proforma.new
    input.name = params[:name]
    input.address = params[:address]
    input.state = params[:state]
    input.sqft = params[:sqft]
    input.units = params[:units]
    # input.p = params[:purchase_price]
    # input.sale = params[:sale_price]
    # input.rev_growth = params[:rev_growth]
    # input.opex_growth = params[:opex_growth]
    # input.vacancy = params[:vacancy]
    # input.r = params[:discount_rate]
    input.save

    input = Revenue.new
    input.rent = params[:rent]
    input.parking = params[:parking]
    input.storage = params[:storage]
    input.pet = params[:pet]
    input.laundry = params[:laundry]
    input.vending = params[:vending]
    input.save

    input = OperatingExpense.new
    input.mf = params[:management_fees]
    input.af = params[:administrative_fees]
    input.pb = params[:payroll_and_benefits]
    input.maint = params[:maintenance]
    input.maint = params[:utilities]
    input.maint = params[:maintenance]
    input.maint = params[:real_estate_taxes]
    input.maint = params[:miscellaneous]
    input.maint = params[:proforma_id]
    input.save

    redirect_to '/proformas/:id'
  end


  def show
   @name = params[:name]
   @address = params[:address]
   @state = params[:state]
   @sqft = params[:sqft].to_i
   rent = params[:rent].to_f
   parking = params[:parking].to_f
   storage = params[:storage].to_f
   pet = params[:pet].to_f
   laundry = params[:laundry].to_f
   vending = params[:vending].to_f
   @total_revenue = rent+parking+storage+pet+laundry+vending

   management_fees = params[:management_fees].to_f
   administrative_fees = params[:administrative_fees].to_f
   payroll = params[:payroll].to_f
   maintenance = params[:maintenance].to_f
   utilities = params[:utilities].to_f
   insurance = params[:insurance].to_f
   re_taxes = params[:re_taxes].to_f
   miscellaneous = params[:miscellaneous].to_f
   @total_opex = management_fees+administrative_fees+payroll+maintenance+utilities+insurance+re_taxes+miscellaneous

   @noi = @total_revenue - @total_opex

   rev_growth = params[:rev_growth].to_f
   opex_growth = params[:opex_growth].to_f

   @total_rev_year2 = @total_revenue * (1 + rev_growth)
   @total_opex_year2 = @total_opex * (1 + opex_growth)
   @noi_year2 = @total_rev_year2 - @total_opex_year2

   @total_rev_year3 = @total_rev_year2 * (1 + rev_growth)
   @total_opex_year3 = @total_opex_year2 * (1 + opex_growth)
   @noi_year3 = @total_rev_year3 - @total_opex_year3


   # @sale_price = params[:sale_price]
   # irr =

    #r = params[:discount_rate]
    #discount_rate

    r = params[:discount_rate].to_f
    #r = 0.07
    p = params[:purchase_price].to_f

    sale = params[:sale_price].to_f


   @npv = -p + @noi/(1+r)**1 + @noi_year2/(1+r)**2 + (@noi_year3+sale)/(1+r)**3

   if @npv < 0
    puts "This is a bad investment"
   else
    puts "This is a good investment"
   end #how do i get this to render in erb?



  end

end