defmodule Podder.PodderTest do
  use Podder.DataCase

  alias Podder.Podder

  describe "users" do
    alias Podder.Podder.User

    @valid_attrs %{user_name: "some user_name"}
    @update_attrs %{user_name: "some updated user_name"}
    @invalid_attrs %{user_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Podder.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Podder.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Podder.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Podder.create_user(@valid_attrs)
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Podder.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Podder.update_user(user, @update_attrs)
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Podder.update_user(user, @invalid_attrs)
      assert user == Podder.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Podder.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Podder.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Podder.change_user(user)
    end
  end

  describe "podcasts" do
    alias Podder.Podder.Podcast

    @valid_attrs %{podcast_name: "some podcast_name"}
    @update_attrs %{podcast_name: "some updated podcast_name"}
    @invalid_attrs %{podcast_name: nil}

    def podcast_fixture(attrs \\ %{}) do
      {:ok, podcast} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Podder.create_podcast()

      podcast
    end

    test "list_podcasts/0 returns all podcasts" do
      podcast = podcast_fixture()
      assert Podder.list_podcasts() == [podcast]
    end

    test "get_podcast!/1 returns the podcast with given id" do
      podcast = podcast_fixture()
      assert Podder.get_podcast!(podcast.id) == podcast
    end

    test "create_podcast/1 with valid data creates a podcast" do
      assert {:ok, %Podcast{} = podcast} = Podder.create_podcast(@valid_attrs)
      assert podcast.podcast_name == "some podcast_name"
    end

    test "create_podcast/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Podder.create_podcast(@invalid_attrs)
    end

    test "update_podcast/2 with valid data updates the podcast" do
      podcast = podcast_fixture()
      assert {:ok, %Podcast{} = podcast} = Podder.update_podcast(podcast, @update_attrs)
      assert podcast.podcast_name == "some updated podcast_name"
    end

    test "update_podcast/2 with invalid data returns error changeset" do
      podcast = podcast_fixture()
      assert {:error, %Ecto.Changeset{}} = Podder.update_podcast(podcast, @invalid_attrs)
      assert podcast == Podder.get_podcast!(podcast.id)
    end

    test "delete_podcast/1 deletes the podcast" do
      podcast = podcast_fixture()
      assert {:ok, %Podcast{}} = Podder.delete_podcast(podcast)
      assert_raise Ecto.NoResultsError, fn -> Podder.get_podcast!(podcast.id) end
    end

    test "change_podcast/1 returns a podcast changeset" do
      podcast = podcast_fixture()
      assert %Ecto.Changeset{} = Podder.change_podcast(podcast)
    end
  end
end
