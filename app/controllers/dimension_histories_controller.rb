class DimensionHistoriesController < ApplicationController
  before_action :load_dimensions, only: [:index]

  def index
    
  end

  def get_dimensions
    api_result = generate_random_json(params[:height], params[:width], params[:length], params[:weight])

    if api_result.present?
      @dimension_history = DimensionHistory.create(
        url: params[:url],
        datetime: api_result["datetime"],
        mac_address: api_result["mac_address"],
        result_code: api_result["result_code"],
        result_name: api_result["result_name"],
        width: api_result["width"],
        length: api_result["length"],
        height: api_result["height"],
        weight: api_result["weight"]
      )

      load_dimensions
      flash[:notice] = 'Kết quả đã được lưu vào cơ sở dữ liệu.'
    else
      flash[:alert] = 'Không thể lấy kết quả.'
    end

    redirect_to root_path
  end

  private

  def load_dimensions
    @dimension_histories = DimensionHistory.order(datetime: :desc)
  end

  def generate_random_json(height, width, length, weight)
    temp = rand(2)
    data = {
      "datetime" => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
      "mac_address" => generate_random_mac_address,
      "result_code" => temp,
      "result_name" => (temp == 0 ? "Success" : "Failure"),
      "width" => "#{width}cm",
      "length" => "#{length}cm",
      "height" => "#{height}cm",
      "weight" => "#{weight}kg"
    }

    return data
  end

  def generate_random_mac_address
    mac_address = (0..5).map { '%02x' % rand(256) }.join(':')
    return mac_address
  end
end
