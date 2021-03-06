require 'csv'
require 'fastercsv'

class CollegesController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /colleges
  # GET /colleges.xml
  layout 'admin'
  def index
    @colleges = College.order(sort_column + " " + sort_direction).paginate(:page =>1,:per_page=>2)
    #search(params[:search], params[:page])
    #paginate(:page =>3,:per_page=>2 )paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @colleges }
    end
  end

  # GET /colleges/1
  # GET /colleges/1.xml
  def show
    @college = College.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @college }
    end
  end

  # GET /colleges/new
  # GET /colleges/new.xml
  def new
    @college = College.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @college }
    end
  end

  # GET /colleges/1/edit
  def edit
    @college = College.find(params[:id])
  end

  # POST /colleges
  # POST /colleges.xml
  def create
    @college = College.new(params[:college])

    respond_to do |format|
      if @college.save
        format.html { redirect_to(@college, :notice => 'College was successfully created.') }
        format.xml  { render :xml => @college, :status => :created, :location => @college }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @college.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /colleges/1
  # PUT /colleges/1.xml
  def update
    @college = College.find(params[:id])

    respond_to do |format|
      if @college.update_attributes(params[:college])
        format.html { redirect_to(@college, :notice => 'College was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @college.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /colleges/1
  # DELETE /colleges/1.xml
  def destroy
    @college = College.find(params[:id])
    @college.destroy

    respond_to do |format|
      format.html { redirect_to(colleges_url) }
      format.xml  { head :ok }
    end
  end
  
  def import 
  
  end
  def csv_import
  @parsed_file=CSV::Reader.parse(params[:file])
     n=0
     @parsed_file.each do |row|
         c=College.new

         c.college_Name=row[0]
         c.code=row[1]
         c.address=row[2]
         c.establish_Year=row[3]
  
         if c.save
             n=n+1
             GC.start if n%50==0
         end
         flash.now[:message]="CSV Import Successful,  #{n} new records added to data base"

     end
  end
  def export_csv
  @colleges = College.all#search(params[:search]).order("name")
    outfile = "college" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["college_Name","code","address","establish_Year","CraetedAt"]
      @colleges.each do |college|
        csv << [college.college_Name,college.code,college.address,college.establish_Year,college.created_at.strftime('%d-%m-%Y %H:%M:%S')]
      end
    end
    send_data csv_data,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=#{outfile}"
 
  end 
  def xls_import
  
  end 
 end
 
 private

  def sort_column
 College.column_names.include?(params[:sort]) ? params[:sort] :"college_Name"
 #College.column_names.include?(params[:sort]) ? params[:sort] :"code"    
     end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
 

