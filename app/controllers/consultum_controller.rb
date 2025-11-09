class ConsultumController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consultum, only: %i[ show edit update destroy ]

  # GET /consultum or /consultum.json
  def index
    # Adiciona o .page(params[:page]) do Kaminari
    @consulta = Consultum.order(data_consulta: :desc).page(params[:page])
  end
  # GET /consultum/1 or /consultum/1.json
  def show
  end

  # GET /consultum/new
  def new
    @consultum = Consultum.new
  end

  # GET /consultum/1/edit
  def edit
  end

  # POST /consultum or /consultum.json
  def create
    @consultum = Consultum.new(consultum_params)

    respond_to do |format|
      if @consultum.save
        format.html { redirect_to @consultum, notice: "Consulta marcada!" }
        format.json { render :show, status: :created, location: @consultum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @consultum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consultum/1 or /consultum/1.json
  def update
    respond_to do |format|
      if @consultum.update(consultum_params)
        format.html { redirect_to @consultum, notice: "Consulta atualizada.", status: :see_other }
        format.json { render :show, status: :ok, location: @consultum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @consultum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consultum/1 or /consultum/1.json
  def destroy
    @consultum.destroy!

    respond_to do |format|
      format.html { redirect_to consultum_index_path, notice: "Consulta removida do sistema.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consultum
      @consultum = Consultum.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def consultum_params
      params.expect(consultum: [ :medico_id, :paciente_id, :data_consulta ])
    end
end
