class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients or /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client = Client.find_by(id: params[:id])
  
    if @client
      # Elimina todas las películas relacionadas con el cliente
      @client.movies.destroy_all
  
      # Ahora puedes eliminar al cliente
      @client.destroy
  
      respond_to do |format|
        format.html { redirect_to clients_url, notice: "Client and related movies were successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to clients_url, alert: "Client not found"
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      def set_client
        @client = Client.find_by(id: params[:id])
        if @client.nil?
          # Manejar el caso en el que el cliente no existe
          redirect_to clients_path, alert: "Cliente no encontrado"
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name, :age, :address)
    end
end
