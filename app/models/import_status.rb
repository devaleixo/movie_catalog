class ImportStatus < ApplicationRecord
  belongs_to :user

  # Status possíveis
  STATUSES = %w[pending processing completed failed].freeze

  validates :filename, presence: true
  validates :status, inclusion: { in: STATUSES }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :pending, -> { where(status: 'pending') }
  scope :processing, -> { where(status: 'processing') }
  scope :completed, -> { where(status: 'completed') }
  scope :failed, -> { where(status: 'failed') }

  # Métodos de status
  def pending?
    status == 'pending'
  end

  def processing?
    status == 'processing'
  end

  def completed?
    status == 'completed'
  end

  def failed?
    status == 'failed'
  end

  # Atualizar progresso
  def update_progress!(processed:, success:, errors:)
    update!(
      processed_rows: processed,
      success_count: success,
      error_count: errors
    )
  end

  # Marcar como processando
  def start_processing!
    update!(
      status: 'processing',
      started_at: Time.current,
      processed_rows: 0,
      success_count: 0,
      error_count: 0
    )
  end

  # Marcar como completo
  def mark_completed!
    update!(
      status: 'completed',
      completed_at: Time.current
    )
  end

  # Marcar como falho
  def mark_failed!(error_message)
    update!(
      status: 'failed',
      completed_at: Time.current,
      error_messages: error_message
    )
  end

  # Tempo de processamento
  def processing_time
    return nil unless completed_at && started_at
    (completed_at - started_at).round(2)
  end
end
