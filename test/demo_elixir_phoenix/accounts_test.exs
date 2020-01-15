defmodule DemoElixirPhoenix.AccountsTest do
  use DemoElixirPhoenix.DataCase

  alias DemoElixirPhoenix.Accounts

  describe "users" do
    alias DemoElixirPhoenix.Accounts.User

    @valid_attrs %{about: "some about", birth_date: ~D[2010-04-17], email: "some email", name: "some name", phone: "some phone", photo_uri: "some photo_uri", web: "some web"}
    @update_attrs %{about: "some updated about", birth_date: ~D[2011-05-18], email: "some updated email", name: "some updated name", phone: "some updated phone", photo_uri: "some updated photo_uri", web: "some updated web"}
    @invalid_attrs %{about: nil, birth_date: nil, email: nil, name: nil, phone: nil, photo_uri: nil, web: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.about == "some about"
      assert user.birth_date == ~D[2010-04-17]
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.phone == "some phone"
      assert user.photo_uri == "some photo_uri"
      assert user.web == "some web"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.about == "some updated about"
      assert user.birth_date == ~D[2011-05-18]
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.phone == "some updated phone"
      assert user.photo_uri == "some updated photo_uri"
      assert user.web == "some updated web"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
