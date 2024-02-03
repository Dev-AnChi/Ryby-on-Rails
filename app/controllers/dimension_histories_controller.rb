require 'json'

class DimensionHistoriesController < ApplicationController
  before_action :load_dimensions, only: [:index, :get_dimensions]

  def index
  end

  def get_dimensions
    # Tạo dữ liệu ngẫu nhiên từ các giá trị nhập vào
    api_result = generate_random_json(params[:height], params[:width], params[:length], params[:weight])

    # Kiểm tra xem có kết quả hay không
    if api_result.present?
      # Lưu kết quả vào bảng DimensionHistory
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

      # Lấy tất cả kết quả từ bảng DimensionHistory để hiển thị
      @dimension_histories = DimensionHistory.all
    else
      # Xử lý khi không có kết quả
      flash[:alert] = 'Không thể lấy kết quả'
      redirect_to root_path
    end

    # Hiển thị JSON đẹp mắt
    @api_result = api_result.present? ? JSON.pretty_generate(api_result) : nil
    respond_to do |format|
      format.json { render json: @api_result }  # Sửa lại để trả về @api_result
      format.js   # Phản hồi định dạng JavaScript
    end
  rescue StandardError => e
    # Ghi log cho lỗi
    puts "Lỗi : #{e.message}"
    flash[:alert] = 'Có lỗi.'
    redirect_to root_path
  end

  private

  def load_dimensions
    # Lấy tất cả kết quả từ bảng DimensionHistory để hiển thị
    @dimension_histories = DimensionHistory.all
  end

  def generate_random_json(height, width, length, weight)
    # Tạo dữ liệu mẫu ngẫu nhiên từ các giá trị nhập vào
    data = {
      "datetime" => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
      "mac_address" => generate_random_mac_address,
      "result_code" => rand(2),  # Assume result_code can be 0 or 1
      "result_name" => (rand(2) == 0 ? "Success" : "Failure"),
      "width" => "#{width}cm",
      "length" => "#{length}cm",
      "height" => "#{height}cm",
      "weight" => "#{weight}kg"
    }

    return data
  end

  def generate_random_mac_address
    # Tạo địa chỉ MAC ngẫu nhiên
    mac_address = (0..5).map { '%02x' % rand(256) }.join(':')
    return mac_address
  end
end
