defmodule Demo.AccountsTest do
  use Demo.DataCase

  alias Demo.Accounts

  describe "users" do
    alias Demo.Accounts.User

    @valid_attrs %{about: "some about", email: "some email", name: "some name", phone: "some phone", web: "some web"}
    @update_attrs %{about: "some updated about", email: "some updated email", name: "some updated name", phone: "some updated phone", web: "some updated web"}
    @invalid_attrs %{about: nil, email: nil, name: nil, phone: nil, web: nil}

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
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.phone == "some phone"
      assert user.web == "some web"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.about == "some updated about"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.phone == "some updated phone"
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
