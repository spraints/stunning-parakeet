class RepositoriesController < SignedInController
  def index
    @repositories = current_user.repositories
  end
end
