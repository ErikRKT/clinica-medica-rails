class MedicosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medico, only: %i[ show edit update destroy ]

  # GET /medicos or /medicos.json
  def index
    @medicos = Medico.all
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Relatório de Médicos", size: 20, style: :bold
        @medicos.each do |medico|
          pdf.text "Nome: #{medico.nome} | CRM: #{medico.crm} | Especialidade: #{medico.especialidade}"
        end
        send_data pdf.render, filename: "relatorio_medicos.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
  # GET /medicos/1 or /medicos/1.json
  def show
  end

  # GET /medicos/new
  def new
    @medico = Medico.new
  end

  # GET /medicos/1/edit
  def edit
  end

  # POST /medicos or /medicos.json
  def create
    @medico = Medico.new(medico_params)

    respond_to do |format|
      if @medico.save
        format.html { redirect_to @medico, notice: "O Médico foi cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @medico }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicos/1 or /medicos/1.json
  def update
    respond_to do |format|
      if @medico.update(medico_params)
        format.html { redirect_to @medico, notice: "Médico atualizado com sucesso", status: :see_other }
        format.json { render :show, status: :ok, location: @medico }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicos/1 or /medicos/1.json
  def destroy
    @medico.destroy!

    respond_to do |format|
      format.html { redirect_to medicos_path, notice: "Médico removido.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medico
      @medico = Medico.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def medico_params
      params.expect(medico: [ :nome, :crm, :especialidade ])
    end
end
