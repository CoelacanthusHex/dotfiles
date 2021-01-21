Dotfiles of Coelacanthus
=========================

Managed by `stow <https://www.gnu.org/software/stow/>`_ .

Usage
-------

.. code-block:: shell
    ./stow.sh zsh <group>

List
-------

*   ``package.list``: 每份配置文件对应所需的软件
*   ``dot-setup.sh``: 每份配置需要进行的手工操作
*   ``stow.sh``: 用于快速部署，使用方法见 `Usage`_
*   ``pacman-backup/``: 用于存放 ``pacman`` 配置备份，使用 ``pacman/`` 下的 ``pacman-backup`` 脚本生成
